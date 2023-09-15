import React, { useState } from 'react';
import styled from 'styled-components';
import { Chart } from 'react-google-charts';

const SliderContainer = styled.div`
  overflow: hidden;
  width: 360px;
  margin: 35px auto;
`;

const Slide = styled.div`
  min-width: 100%;
  display: grid;
  place-items: center;
  transition: transform 0.3s ease;
  grid-column: span 1;
`;

const Slider = styled.div`
  display: grid;
  grid-template-columns: repeat(2, 100%);
  transition: transform 0.3s ease;
  transform: translateX(-${(props) => props.slideIndex * 100}%);
`;

const ButtonContainer = styled.div`
  display: grid;
  grid-template-columns: repeat(2, auto);
  justify-content: center;
`;

const Button = styled.button`
  background-color: ${({ isBlack }) => (isBlack ? 'black' : '#878787')};
  color: #fff;
  border: none;
  border-radius: 50%;
  padding: 5px 5px;
  margin: 10px;
  cursor: pointer;
`;

// 차트 스타일
const ChartBox1 = styled.div`
  width: 350px;
  height: 476px;
  border-radius: 30px;
  background-color: #ffffff;
  border: 1px solid rgba(0, 0, 0, 0.25);
  margin: 0 auto;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const ChartBox2 = styled.div`
  width: 350px;
  height: 476px;
  border-radius: 30px;
  background-color: #ffffff;
  border: 1px solid rgba(0, 0, 0, 0.25);
  margin: 0 auto;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const ChartContainer1 = styled.div`
  width: 350px;
  height: 476px;
  background-color: white;
  border-radius: 15px;
  border: 1px solid rgba(135, 135, 135, 0.3);
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const ChartContainer2 = styled.div`
  width: 350px;
  height: 476px;
  background-color: white;
  border-radius: 15px;
  border: 1px solid rgba(135, 135, 135, 0.3);
  cursor: pointer;
`;

const SportChart = function () {
  const [slideIndex, setSlideIndex] = useState(0);

  const nextSlide = () => {
    setSlideIndex(slideIndex + 1);
  };

  const prevSlide = () => {
    setSlideIndex(slideIndex - 1);
  };

  // 차트 데이터
  const chartData1 = [
    ['', '운동 분'],
    ['월', 60],
    ['화', 45],
    ['수', 30],
    ['목', 75],
    ['금', 90],
    ['토', 120],
    ['일', 60],
  ];

  const chartOptions1 = {
    legend: { position: 'none' },
    chart: {
      title: 'Daily Diet',
    },
  };

  const chartData2 = [
    ["Task", "운동칼로리", "섭취칼로리"],
    ["월", 8, 2],
    ["화", 2, 1],
    ["수", 4, 3],
    ["목", 10, 5],
    ["금", 10, 6],
    ["토", 10, 4],
    ["일", 10, 7]
  ];
  
  const chartOptions2 = {
    title: "칼로리 계산(운동으로 소비한 칼로리 - 섭취한 칼로리)",
    legend: { position: "top" },
    hAxis: { title: "칼로리" },
    vAxis: { title: "요일" }, 
    bars: "horizontal", 
  };

  return (
    <>
      <SliderContainer>
        <Slider slideIndex={slideIndex}>
          <Slide>
              <ChartBox1>
                <ChartContainer1>
                  <Chart
                    chartType="Bar"
                    width="300px"
                    height="460px"
                    data={chartData1}
                    options={chartOptions1}
                    graph_id="barchart1"
                  />
                </ChartContainer1>
              </ChartBox1>
          </Slide>
          <Slide>
              <ChartBox2>
                <ChartContainer2>
                <Chart
                    chartType="BarChart"
                    width="350px"
                    height="476px"
                    data={chartData2}
                    options={chartOptions2}
                    graph_id="barchart2"
                />
                </ChartContainer2>
              </ChartBox2>
          </Slide>
        </Slider>
      </SliderContainer>

      <ButtonContainer>
        <Button
          onClick={prevSlide}
          disabled={slideIndex === 0}
          isBlack={slideIndex === 0}
        ></Button>
        <Button
          onClick={nextSlide}
          disabled={slideIndex === 1}
          isBlack={slideIndex === 1}
        ></Button>
      </ButtonContainer>
    </>
  );
};

export default SportChart;